" Vim plugin file
" Original Author: Maksim Ryzhikov <rv.maksim@gmail.com>
" Updated by: Rudkovsky Vyacheslav <rudkovsky@ymail.com>
" Version: 0.1
" ----------------------------------------------------------------------------
" Settings:
"          let g:vtranslate="T"       note: Translate selected text in visual-mode
"          :echohl <TAB>              note: Color tranlated text

if !exists(":Translate")
	command! -nargs=* -complet=custom,Gcomplete Translate call GoogleTranslator('<args>')
endif

func! Gcomplete(A,L,C)
endfunction


if exists("g:vtranslate")
	nnoremap <silent> <plug>TranslateBlockText :call TranslateBlockText()<cr>
	vnoremap <silent> <plug>TranslateBlockText <ESC>:call TranslateBlockText()<cr>
	let cmd = "vmap ".g:vtranslate." <Plug>TranslateBlockText"
	exec cmd
endif


func! TranslateBlockText()
	let start_v = col("'<") - 1
	let end_v = col("'>")
	let lines = getline("'<","'>")

	if len(lines) > 1
		let lines[0] = strpart(lines[0],start_v)
		let lines[-1] = strpart(lines[-1],0,end_v)
		let str = join(lines)
	else
		let str = strpart(lines[0],start_v,end_v-start_v)
	endif

	call GoogleTranslator(str)
endfunction



func! GoogleTranslator(...)

	if !has("ruby")
		echohl ErrorMsg
		echon "Sorry about that, Google Translator requires ruby support. And ruby gem google-translate"
		finish
	endif

	if !exists("g:langpair")
		echohl WarningMsg
		echon "Currenty using a default langpair. Please define g:langpair in .vimrc"
	endif

	let s:query = a:000
	let s:langpair = exists("g:langpair") ? g:langpair : "ru"

	func! Query()
		return s:query
	endfunction

	func! Langpair()
		return s:langpair
	endfunction

	call s:_cmdOutputText()

endfunction

func! s:_cmdOutputText()

ruby <<EOF
require "rubygems"
require "google_translate"

class Translate


  def initialize
    @translator = Google::Translator.new
  end

  def run(language, text)
    
    case language
       
    when /(.*):(.*)/ then
      from = $1
      to = $2
      puts @translator.translate(from.to_sym, to.to_sym, text)
    when /(.*)/ then
      from = @translator.detect_language(text)['language']
      to = $1
      begin
        puts @translator.translate(from.to_sym, to.to_sym, text)
      rescue Exception => e
        puts "Error: " + e.message
      end
    end
  end
end

langpair = VIM::evaluate('Langpair()')
query = VIM::evaluate('Query()')

query.each do |q|
   query = q.downcase.capitalize
end

text = Translate.new.run(langpair, query)

VIM::evaluate("ViewTranlatedText('#{text}')")
EOF

endfunction

func! ViewTranlatedText(text)
		echon a:text
endfunction
