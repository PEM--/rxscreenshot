Package.describe({
  name: 'pierreeric:rxscreenshot',
  version: '0.1.0',
  summary: 'Create reactively a PNG as a Buffer from elements within your Blaze template.',
  git: 'https://github.com/PEM--/rxscreenshot.git',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');
  // Required packages
  api.use([
    // Package from MDG
    'coffeescript',
    'reactive-var',
    'jquery',
    // Community packages
    'mquandalle:bower@1.5.2_1'
  ]);
  // Imported files
  api.addFiles([
    'rxScreenshot.coffee',
    'bower.json'
  ], 'client');
});
