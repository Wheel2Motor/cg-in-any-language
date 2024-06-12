" for new grammer feature support
set nocompatible

" dependency
source image.vim
source io-ppm.vim

" img1
let width = 512
let height = 512
let img1 = ImageNew(width, height)
call img1.Flood(0, 0, 0, 0)
for row in range(height)
	for col in range(width)
		call img1.SetPixel(row, col,
					\row % 256,
					\col % 256,
					\(row * col + row + col) % 256,
					\0,
					\)
	endfor
endfor
call PPMWrite(img1, "img1.ppm")

" img2
let img2 = PPMRead("img1.ppm")
call img2.Invert(g:ImageChannel_RGB)
call PPMWrite(img2, "img2.ppm")

exit
