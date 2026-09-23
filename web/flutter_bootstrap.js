{{flutter_js}}
{{flutter_build_config}}

const removeAppLoader = () => {
  const loader = document.getElementById('app-loader');
  if (!loader) return;
  loader.classList.add('is-hidden');
  window.setTimeout(() => loader.remove(), 260);
};

window.addEventListener('flutter-first-frame', removeAppLoader, {
  once: true,
});

_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
    window.setTimeout(removeAppLoader, 2500);
  },
});
