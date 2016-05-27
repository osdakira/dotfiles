# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"
process.env.PATH = "/usr/local/bin:#{process.env.HOME}/.rbenv/shims:#{process.env.HOME}/.rbenv/bin:#{process.env.PATH}"

atom.commands.add 'atom-text-editor', 'custom:copy', ->
  view = atom.views.getView atom.workspace.getActiveTextEditor()
  atom.commands.dispatch view, 'core:copy'
  atom.commands.dispatch view, 'atomic-emacs:copy-region-as-kill'
