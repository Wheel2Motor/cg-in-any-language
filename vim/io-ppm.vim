if exists('g:cg_io_ppm')
	finish
else
	let g:cg_io_ppm = expand("<sfile>")
endif


source image.vim


function! PPMWrite(img, path, edition=3, step=255) abort
	let codec = &l:fileencoding
	let &l:fileencoding = "gbk"
	try
		set fileencoding=gbk
		let lines = [
					\"P" .. a:edition,
					\string(a:img.width) .. ' ' .. string(a:img.height),
					\string(a:step),
					\]
		for row in range(a:img.height)
			let currow = a:img.buff[row]
			for column in range(a:img.width)
				let pixel = currow[column]
				call add(lines, string(pixel[0]) .. ' ' ..
											 \string(pixel[1]) .. ' ' ..
											 \string(pixel[2])
											 \)
			endfor
		endfor
		call writefile(lines, a:path)
	catch
		let l:exce = substitute(v:exception, '^Vim\%((\a\+)\)\=:', '', '')
    throw l:exce
	finally
		let &l:fileencoding = codec
	endtry
endfunction


function! PPMRead(path) abort
	let lines = readfile(a:path)
	let edition = 0 + lines[0]
	let step = 0 + lines[2]
	let dim = split(lines[1], ' ')
	let width = 0 + dim[0]
	let height = 0 + dim[1]
	let img = ImageNew(width, height)
	let currow = 0
	let curcol = 0
	for idx in range(3, len(lines) - 1)
		let color = split(lines[idx], ' ')
		let r = 0 + color[0]
		let g = 0 + color[1]
		let b = 0 + color[2]
		let a = 0
		call img.SetPixel(currow, curcol, r, g, b, a)
		let curcol += 1
		if curcol >= width
			let curcol = 0
			let currow += 1
		endif
	endfor
	return img
endfunction
