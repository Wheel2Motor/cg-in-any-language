if exists('g:cg_math_vec3')
	finish
else
	let g:cg_math_vec3 = expand("<sfile>")
endif


function Vec3New(x=0.0, y=0.0, z=0.0) abort
	let res = { 'x': a:x * 1.0, 'y': a:y * 1.0, 'z': a:z * 1.0 }
	let res.Print     = function('<SID>Vec3Print')
	let res.Add       = function('<SID>Vec3Add')
	let res.Sub       = function('<SID>Vec3Sub')
	let res.Mul       = function('<SID>Vec3Mul')
	let res.Dot       = function('<SID>Vec3Dot')
	let res.Cross     = function('<SID>Vec3Cross')
	let res.Length    = function('<SID>Vec3Length')
	let res.Normalize = function('<SID>Vec3Normalize')
	let res.Project   = function('<SID>Vec3Project')
	let res.Reflect   = function('<SID>Vec3Reflect')
	return res
endfunction


function! s:Vec3Print() dict abort
	echom '<Vec3 x=' .. self.x .. ' y=' .. self.y .. ' z=' .. self.z .. '>'
endfunction


function! s:Vec3Add(v) dict abort
	let x = self.x + a:v.x
	let y = self.y + a:v.y
	let z = self.z + a:v.z
	return Vec3New(x, y, z)
endfunction


function! s:Vec3Sub(v) dict abort
	let x = self.x - a:v.x
	let y = self.y - a:v.y
	let z = self.z - a:v.z
	return Vec3New(x, y, z)
endfunction


function! s:Vec3Mul(v) dict abort
	let x = self.x * a:v.x
	let y = self.y * a:v.y
	let z = self.z * a:v.z
	return Vec3New(x, y, z)
endfunction


function! s:Vec3Div(v) dict abort
	let x = self.x / a:v.x
	let y = self.y / a:v.y
	let z = self.z / a:v.z
	return Vec3New(x, y, z)
endfunction


function! s:Vec3Dot(v) dict abort
	let tmp = self.Mul(a:v)
	let res = tmp.x + tmp.y + tmp.z
	return res
endfunction


function! s:Vec3Cross(v) dict abort
	let x = self.y * a:v.z - self.z * a:v.y
	let y = self.z * a:v.x - self.x * a:v.z
	let z = self.x * a:v.y - self.y * a:v.x
	return Vec3New(x, y, z)
endfunction


function! s:Vec3Length() dict abort
	let x = self.x
	let y = self.y
	let z = self.z
	return sqrt(x * x + y * y + z * z)
endfunction


function! s:Vec3Normalize() dict abort
	let length = self.Length()
	if length ==# 0
		return Vec3New()
	else
		return Vec3New(self.x / length, self.y / length, self.z / length)
	endif
endfunction


function! s:Vec3Project(n) dict abort
	let nn = a:n.Normalize()
	let sl = self.Dot(nn)
	let res = nn.Mul(Vec3New(sl, sl, sl))
	return res
endfunction


function! s:Vec3Reflect(n) dict abort
	let shadow = self.Project(a:n)
	let inv = self.Sub(shadow)
	let res = shadow.Sub(inv)
	return res
endfunction

