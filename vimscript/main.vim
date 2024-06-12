" for new grammer feature support
set nocompatible

" dependency
source image.vim
source io-ppm.vim

function s:render_nonsense_image() abort
  " Try to write one image with non-sense pixel data
  let width = 512
  let height = 512
  let img = ImageNew(width, height)
  let path = 'img.ppm'

  let tbeg = localtime()
  for row in range(height)
    for col in range(width)
      call img.SetPixel(row, col,
            \(row + 128) % 256,
            \(col + 128) % 256,
            \(row % max([col, 1])) % 256,
            \0,
            \)
    endfor
  endfor
  call PPMWrite(img, path)

  let tend = localtime()
  call img.Print()
  echom 'Done, ' .. (tend - tbeg) .. 's elapsed.'
  echom 'File: ' .. path
  call input('Any key down to exit.')
endfunction

call <SID>render_nonsense_image()

exit
