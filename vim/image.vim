if exists('g:cg_image')
	finish
else
	let g:cg_image = expand("<sfile>")
endif


let g:ImageChannel_R = 1 << 0
let g:ImageChannel_G = 1 << 1
let g:ImageChannel_B = 1 << 2
let g:ImageChannel_A = 1 << 3
let g:ImageChannel_RGB = or(or(g:ImageChannel_R, g:ImageChannel_G), g:ImageChannel_B)


function! ImageNew(width, height) abort
	let img = {}
	let img.width = a:width
	let img.height = a:height
	let img.buff = []
	let img.Print    = function('<SID>ImagePrint')
	let img.Flood    = function('<SID>ImageFlood')
	let img.SetPixel = function('<SID>ImageSetPixel')
	let img.GetPixel = function('<SID>ImageGetPixel')
	let img.Invert   = function('<SID>ImageInvert')
	for row in range(a:height)
		call add(img.buff, [])
		let currow = img.buff[row]
		for column in range(a:width)
			call add(currow, [0, 0, 0, 0])
		endfor
	endfor
	return img
endfunction


function! s:ImagePrint() dict abort
	echom '<Image width=' .. self.width .. ' height=' .. self.height .. '>'
endfunction


function! s:ImageFlood(r, g, b, a) dict abort
	for row in range(self.height)
		let currow = self.buff[row]
		for column in range(self.width)
			let currow[column] = [a:r, a:g, a:b, a:a]
		endfor
	endfor
endfunction


function! s:ImageSetPixel(row, col, r, g, b, a) dict abort
	let self.buff[a:row][a:col] = [a:r, a:g, a:b, a:a]
endfunction


function! s:ImageGetPixel(row, col) dict abort
	return copy(self.buff[a:row][a:col])
endfunction


function! s:ImageInvert(channel=g:ImageChannel_RGB) dict abort
	for row in range(self.height)
		let currow = self.buff[row]
		for column in range(self.width)
			let pixel = currow[column]
			let [r, g, b, a] = pixel
			if and(g:ImageChannel_R, a:channel) | let r = 255 - r | endif
			if and(g:ImageChannel_G, a:channel) | let g = 255 - g | endif
			if and(g:ImageChannel_B, a:channel) | let b = 255 - b | endif
			if and(g:ImageChannel_A, a:channel) | let a = 255 - a | endif
			let currow[column] = [r, g, b, a]
		endfor
	endfor
endfunction
