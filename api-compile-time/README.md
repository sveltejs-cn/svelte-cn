通常，你不会直接和 Svelte 编译器打交道，但是你可以在构建系统中通过打包插件（bundler plugins）的形式把它整合进去：

- 对于 [Rollup](https://rollupjs.org/) 用户可以使用 [rollup-plugin-svelte](https://github.com/rollup/rollup-plugin-svelte)
- 对于 [webpack](https://webpack.js.org/) 用户可以使用 [svelte-loader](https://github.com/rollup/rollup-plugin-svelte)
- 对于 [Parcel](https://parceljs.org/) 用户可以使用 [parcel-plugin-svelte](https://github.com/DeMoorJasper/parcel-plugin-svelte)

尽管如此，鉴于打包插件通常会暴露编译器选项（compiler option）给你，知道如何使用编译器会非常有帮助。
