Package.describe({
  name: 'pierreeric:rxscreenshot',
  version: '0.0.2',
  summary: 'Create reactively a PNG as a Buffer from elements within your Blaze template.',
  git: 'https://github.com/PEM--/rxscreenshot.git',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');
  // Required packages
  api.use([
    // Package from MDG
    'coffeescript',
    'reactive-var',
    'jquery',
    // Community packages
    'mquandalle:bower@1.4.1'
  ]);
  // Imported files
  api.addFiles([
    'rxScreenshot.coffee',
    'bower.json'
  ], 'client');
});
