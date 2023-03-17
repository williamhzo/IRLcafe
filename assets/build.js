const esbuild = require("esbuild");
const sveltePlugin = require("esbuild-svelte");

const args = process.argv.slice(2);
const watch = args.includes("--watch");
const deploy = args.includes("--deploy");

const loader = {
  // Add loaders for images/fonts/etc, e.g. { '.svg': 'file' }
};

const plugins = [
  sveltePlugin(),
  // Add and configure plugins here
];

let opts = {
  entryPoints: [
    "js/app.js",
    // ... other here
  ],
  mainFields: ["svelte", "browser", "module", "main"],
  chunkNames: "chunks/[name]-[hash]",
  splitting: true,
  format: "esm",
  bundle: true,
  target: "es2017",
  outdir: "../priv/static/assets",
  external: ["/fonts/*", "/images/*"],
  logLevel: "info",
  loader,
  plugins,
};

if (watch) {
  opts = {
    ...opts,
    watch,
    sourcemap: "inline",
  };
}

if (deploy) {
  opts = {
    ...opts,
    minify: true,
  };
}

const promise = esbuild.build(opts);

if (watch) {
  promise.then((_result) => {
    process.stdin.on("close", () => {
      process.exit(0);
    });

    process.stdin.resume();
  });
}
