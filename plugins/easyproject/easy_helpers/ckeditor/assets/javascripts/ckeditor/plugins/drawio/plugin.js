CKEDITOR.plugins.add( 'drawio', {
    init: function( editor ) {
        editor.addCommand( 'cmd-drawio', {
            exec: function( editor ) {
                editor.insertHtml( '<strong><em>{{drawio_attach(myDiagram)}}</em></strong><br>' );
            }
        });
        editor.ui.addButton( 'Drawio', {
            label: 'Draw.io',
            command: 'cmd-drawio',
icon: this.path + 'icons/drawio.png'
        });
    }
});
