if exists('g:loaded_sqhell')
    finish
endif

let g:loaded_sqhell = 1
let g:sqh_provider = get(g:, 'sqh_provider', 'mysql')
let g:sqh_connection = get(g:, 'sqh_connection', 'default')
let g:sqh_results_limit = get(g:, 'sqh_results_limit', 100)
let g:sqh_results_output = get(g:, 'sqh_results_output', 'nosplit')

" let g:conns_truta = json_decode(execute('cat ~/.sqhell_conns.json'))

command! -nargs=0 SQHShowDatabases execute "call " . g:sqh_provider . "#ShowDatabases()"
command! -nargs=1 SQHShowTablesForDatabase execute "call " . g:sqh_provider . "#ShowTablesForDatabase('" . <q-args> . "')"
command! -nargs=? -complete=file SQHExecuteFile call sqhell#ExecuteFile(<q-args>)
command! -bang -range -nargs=* SQHExecute <line1>,<line2>:call sqhell#Execute(<q-args>, <bang>0)
command! -nargs=1 -complete=custom,sqhell#GetHosts SQHSwitchConnection call sqhell#SwitchConnection(<q-args>)
command! -nargs=1 SQHDropDatabase execute ":call " . g:sqh_provider . "#DropDatabase(<q-args>, 0)"
command! -nargs=+ SQHDropTableFromDatabase execute ":call " . g:sqh_provider . "#DropTableFromDatabase(<f-args>, 0)"
command! -nargs=* SQHSortResults execute ':call ' . g:sqh_provider . '#SortResults(<f-args>)'
" TODO: Inspect de tabelas
" command! -nargs=0 ShowTableDetails execute "call " . g:sqh_provider . "#ShowTableDetails()"
command! -nargs=1 ShowTableDetails execute "call " . g:sqh_provider . "#ShowTableDetails('" . <q-args> . "')"
" TODO Fazendo listagem de procedures e functions
command! -nargs=* SQHShowFunctionsAndProcedures execute ':call ' . g:sqh_provider . '#FunctionsAndProcedures(<f-args>)'
" TODO Novas Conexões
command! -nargs=* SQHNewConn execute ':tabnew ~/.sqhell_conns.json'
command! -nargs=* SQHListConn execute ':!cat ~/.sqhell_conns.json'
