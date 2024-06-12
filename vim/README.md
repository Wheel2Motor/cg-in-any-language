# CG in VIM

### Requirements

* Install vim8.0 or higher.

* This project was written in legacy vimscript, because vim9script grammer and facilities are not mature.

### Run

* In terminal

  Open your terminal, and enter the following code,
  vim will produce images and then close automatically.
  ```cmd
  vim main.vim -u NONE -S main.vim
  ```

* In vim

  Open `main.vim` and enter `:so %<CR>`, vim will produce images and then close automatically.

  If you don't want it to close automatically, just comment the `exit` at the end of the code.

