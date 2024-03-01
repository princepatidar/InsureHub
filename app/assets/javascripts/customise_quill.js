document.addEventListener('DOMContentLoaded', function() {
  const FontAttributor = Quill.import('attributors/class/font');
  FontAttributor.whitelist = ['sans-serif', 'serif', 'monospace', 'manrope', 'inter'];
  Quill.register(FontAttributor, true);
});
