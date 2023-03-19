import Places from '../components/Places.svelte';

const components = {
  Places,
};

export const SvelteHook = {
  mounted() {
    const componentName = this.el.dataset.name;
    if (!componentName)
      throw new Error('Svelte Component name must be provided');

    const component = components[componentName];
    if (!component)
      throw new Error(`Svelte Component '${componentName}' not found`);

    this._instance = new component({
      target: this.el,
      props: this.svelteProps(),
    });
  },
  updated() {
    // NOTE: Updating properties without re-instantiating the entire object.
    this._instance.$$set(this.svelteProps());
  },
  destroyed() {
    this._instance?.$destroy();
  },
  svelteProps() {
    return {
      ...this.parsedProps(),
      request: this.request.bind(this),
      goto: this.goto.bind(this),
    };
  },
  parsedProps() {
    const props = this.el.dataset.props;
    return props ? JSON.parse(props) : {};
  },
  request(event, data, callback) {
    this.pushEvent(event, data, callback);
  },
  goto(href) {
    liveSocket.pushHistoryPatch(href, 'push', this.el);
  },
};
