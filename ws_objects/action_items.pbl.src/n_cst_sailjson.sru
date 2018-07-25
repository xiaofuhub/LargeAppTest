$PBExportHeader$n_cst_sailjson.sru
forward
global type n_cst_sailjson from nonvisualobject
end type
type json_pair from structure within n_cst_sailjson
end type
end forward

type json_pair from structure
	string		name
	any		value
end type

global type n_cst_sailjson from nonvisualobject
end type
global n_cst_sailjson n_cst_sailjson

type variables
/*
	n_cst_sailjson:from www.pblsoft.com
	Please reserve this information
*/

private:
	json_pair pairs[]
	string is_json
	char ichars[]
	long idx, imaxlen

	treeview tree
	integer objectpcxidx, arraypcxidx, itempcxidx
	string is_ident
public:
	boolean ignoreCase = false
	integer ilevel
	string pair_index

end variables

forward prototypes
public function string parse (string as_json)
public function integer getarray (string itemname, ref any va[])
public function boolean isarray (any value)
public function any getattribute (string itemname)
private function integer of_readobject (n_cst_sailjson vjson, integer alevel)
private subroutine of_error (string msg)
private subroutine skipspc ()
private function long findpairindex (string as_name)
private function string of_getformat (n_cst_sailjson ajson, string ident)
private function string mymid (character vchars[], long vstart, long vlen)
public subroutine buildtree (treeview atree, long handle, integer aobjectpcxidx, integer aarraypcxidx, integer aitempcxidx)
private subroutine of_buildtree (n_cst_sailjson ajson, long handle)
public subroutine setattribute (string as_name, any aa_value)
public function any addarrayitem (string arrayname)
public function any addobject (string objname)
public function string getformatjson (string ident)
end prototypes

public function string parse (string as_json);json_pair pairsnull[]
pairs = pairsnull

is_json = as_json
ichars = as_json
imaxlen = LenA(as_json)
integer li_level = 0

idx = 0
skipspc()
if ichars[idx] = '{' then
	of_readobject(this, li_level)
else
end if


return ''
end function

public function integer getarray (string itemname, ref any va[]);any la
la = GetAttribute(itemname)
if isArray(la) then
	va= la
	return upperbound(va)
end if
return 0
end function

public function boolean isarray (any value);return classname(value)='any'
end function

public function any getattribute (string itemname);long index
if ignoreCase then
	itemname = upper(itemname)
end if
index = findpairindex(itemname)
if index = 0 then
	SignalError(42,"JSON.getAttribute: attribute "+string(itemname,"[general]")+" does not exists!")
	return "!ERROR!"
end if
return pairs[index].value
end function

private function integer of_readobject (n_cst_sailjson vjson, integer alevel);//{....}
integer li_level , pairidx, arrayidx
string ls_name, ls_value
any la_value, la[], lanull[]
n_cst_sailjson ljson

if ichars[idx] <> '{' then
	return -1
end if
li_level = alevel + 1
vjson.ilevel = li_level
skipspc()
do while idx < imaxlen
	//read key name, the first char is "
	if ichars[idx] = '"' then
		idx ++
		ls_name = ''
		ls_value = ''
		do while ichars[idx] <> '"'
			ls_name = ls_name + ichars[idx]
			idx++
		loop
		skipspc()
		if ichars[idx] <> ':' then
			of_error("Error:Expect ':' but not found")
		end if
		skipspc()
		choose case ichars[idx]
			case '"'
				//read string value
				idx ++
				do until ichars[idx] = '"'
					if ichars[idx] = '\' then
						ls_value = ls_value + ichars[idx+1]
						idx = idx + 2
					else
						ls_value = ls_value + ichars[idx]
						idx ++
					end if
				loop
				la_value = ls_value
			case '{'
				//read object
				ljson = create n_cst_sailjson
				of_readobject(ljson, li_level)
				la_value = ljson
			case '['
				skipspc()
				arrayidx = 0
				la=lanull
				do until ichars[idx] = ']'
					arrayidx ++
					la[arrayidx] = create n_cst_sailjson
					of_readobject(la[arrayidx], li_level)
					skipspc()
					if ichars[idx] = ',' then
						skipspc()
					end if
				loop
				la_value = la
			case '0' to '9', '-'			
				do until ichars[idx] = ',' or ichars[idx] = '}'
					ls_value = ls_value + ichars[idx]
					idx ++
				loop
				idx --
				la_value = dec(ls_value)
			case 't'
				if mymid(ichars, idx, 4) = 'true' then
					idx += 3
				else
					of_error('Error:invalid key value!')
				end if
				la_value = true
			case 'f'
				if mymid(ichars, idx, 5) = 'false' then
					idx += 4
				else
					of_error('Error:invalid key value!')
				end if
				la_value = false
			case 'n'
				if mymid(ichars, idx, 4) = 'null' then
					idx += 3
				else
					of_error('Error:invalid key value!')
				end if
				setnull(la_value)
			case else
				of_error('Error:invalid key value!')
		end choose
	
		pairidx ++
		vjson.pairs[pairidx].name = ls_name
		vjson.pairs[pairidx].value = la_value
		if ignoreCase then
			ls_name = upper(ls_name)
		end if
		vjson.pair_index += ";"+ls_name+"="+string(pairidx)
		
		skipspc()
		if ichars[idx] = ',' then
			//read next key and value
			skipspc()
		elseif ichars[idx] = '}' then
			return 1
		end if
		
	else
		of_error('Error:Expect key name with " but not found')
		return -1
	end if
loop

return 1
end function

private subroutine of_error (string msg);SignalError(1025, msg)
//"n_cst_sailjson.getattribute: attribute "+string(itemname,"[general]")+" does not exists!")
end subroutine

private subroutine skipspc ();char c
IDX ++
c = ichars[idx]
do while c=' ' or c='~r' or c='~n' or c='~t' or c='~b' or c='~f'
	idx ++
	c = ichars[idx]
loop
end subroutine

private function long findpairindex (string as_name);long p1, p2, index

p1 = PosA( pair_index, ';'+as_name + "=" )
if p1 < 1 then
	return 0
end if
p1 += 2 + LenA(as_name)
p2 = PosA(pair_index,';',p1)
if p2 < 1 then 
	p2 = LenA( pair_index ) + 1
end if
index = long( MidA( pair_index, p1, p2 - p1 ) )
return index
end function

private function string of_getformat (n_cst_sailjson ajson, string ident);string ls, ls1, ls_return, ls_ident, ls_rtn
integer li,lj, li_max, lj_max
any la, larray[]

if ident <> '' then
	ls_ident = ident + is_ident
	ls_rtn = '~r~n'
end if

li_max = upperbound(ajson.pairs)
for li = 1 to li_max
	la = ajson.pairs[li].value
	ls = '"'+ajson.pairs[li].name+'": '
	if classname(la)='string' then
		ls = ls + '"'+la+'"'
	elseif classname(la)='decimal' then
		ls = ls + string(la)
	elseif classname(la)='boolean' then
		if la = true then
			ls = ls + 'true'
		else
			ls = ls + 'false'
		end if
	elseif isnull(classname(la)) then
		ls = ls+'null'
	elseif classname(la)='any' then
		//ls = ls_names[li]
	else
		ls = ls + string(la)
	end if
	
	
	if classname(la) = 'n_cst_sailjson' then
		ls = ident + ls + '{'+ls_rtn
		ls = ls + of_getformat(la, ls_ident)
		ls = ls + ident + '}'
	elseif classname(la)='any' then
		ls = ident + ls + '['+ls_rtn
		larray = la
		lj_max = upperbound(larray)
		for lj=1 to lj_max
			ls1 = ls_ident + '{'+ls_rtn
			ls1 += of_getformat(larray[lj], ls_ident+is_ident)
			ls1 = ls1 + ls_ident + '}'
			if lj = lj_max then
				ls1 =  ls1 + ''+ls_rtn
			else
				ls1 =  ls1 + ','+ls_rtn
			end if
			ls = ls + ls1
		next
		ls = ls +ident + ']'
	else
		ls = ident + ls
	end if
	if li=li_max then
		ls_return += ls + ''+ls_rtn
	else
		ls_return += ls + ','+ls_rtn
	end if
next

return ls_return

end function

private function string mymid (character vchars[], long vstart, long vlen);string result
long vmax , i

vmax = upperbound(vchars)
if vstart > vmax then
	vstart = vmax
end if
if vstart + vlen -1 > vmax then
	vlen = vmax - vstart +1
end if

for i = vstart to vstart + vlen -1
	result = result + vchars[i]
next
return result
end function

public subroutine buildtree (treeview atree, long handle, integer aobjectpcxidx, integer aarraypcxidx, integer aitempcxidx);tree = atree
objectpcxidx = aobjectpcxidx
arraypcxidx = aarraypcxidx
itempcxidx = aitempcxidx

of_buildtree(this, handle)
end subroutine

private subroutine of_buildtree (n_cst_sailjson ajson, long handle);string ls
integer li,lj, h, pcx, h1
treeviewitem tvi
any la, larray[]

for li = 1 to upperbound(ajson.pairs)
	pcx = itempcxidx
	la = ajson.pairs[li].value
	if classname(la)='string' then
		ls = ajson.pairs[li].name + '="'+la+'"'
	elseif classname(la)='decimal' then
		ls = ajson.pairs[li].name + '='+string(la)
	elseif classname(la)='boolean' then
		ls = ajson.pairs[li].name + '='+string(la)
	elseif classname(la)='any' then
		ls = ajson.pairs[li].name+'['+string(upperbound(la))+']'
		pcx = arraypcxidx
	elseif isnull(classname(la)) then
		ls = ajson.pairs[li].name+'=null'
	else
		ls = ajson.pairs[li].name
		pcx = objectpcxidx
	end if
	tvi.label = ls
	tvi.pictureindex = pcx
	tvi.selectedpictureindex = pcx
	h = tree.insertitemlast( handle, tvi)
	if classname(la) = 'n_cst_sailjson' then
		of_buildtree(la, h)
	elseif classname(la)='any' then
		larray = la
		for lj=1 to upperbound(larray)
			tvi.label='item'+string(lj)
			tvi.pictureindex = objectpcxidx
			tvi.selectedpictureindex = objectpcxidx
			h1 = tree.insertitemlast( h, tvi)
			of_buildtree(larray[lj], h1)
		next
	end if
next
end subroutine

public subroutine setattribute (string as_name, any aa_value);long index
index = findpairindex(as_name)
if index < 1 then
	index = 1 + upperbound(pairs[])
	json_pair pair
	pairs[index] = pair
	pairs[index].name = as_name
	pair_index += ";"+as_name+"="+string(index)
end if
pairs[index].value = aa_value
end subroutine

public function any addarrayitem (string arrayname);n_cst_sailjson ljson
any jsons[]
json_pair pair
integer index

ljson = create n_cst_sailjson

index = findpairindex(arrayname)
if index < 1 then
	index = 1 + upperbound(pairs[])
	pairs[index] = pair
	pairs[index].name = arrayname
	jsons[1] = ljson
	pair_index += ";"+arrayname+"="+string(index)
else
	jsons = pairs[index].value
	jsons[upperbound(jsons)+1] = ljson
end if
pairs[index].value = jsons

return ljson

end function

public function any addobject (string objname);n_cst_sailjson ljson
json_pair pair
integer index

index = 1 + upperbound(pairs[])
pairs[index] = pair
pairs[index].name = objname
ljson = create n_cst_sailjson
pairs[index].value = ljson
pair_index += ";"+objname+"="+string(index)

return ljson

end function

public function string getformatjson (string ident);string ls_return
is_ident = ident

ls_return = '{'

if is_ident <> '' then
	ls_return = ls_return + '~r~n'
end if
ls_return = ls_return + of_getformat(this,is_ident) + '}'
return ls_return
end function

on n_cst_sailjson.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sailjson.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//This class is free to use,  from http://www.pblsoft.com/sailjson.htm by Appeon long.zhang 05.27.2016 (AMA Profiles API)
end event

