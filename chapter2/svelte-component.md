### `<svelte:component>`

```html
<svelte:component this={expression}>
```

`<svelte:component>`会使用指定了`this`属性的组件构造函数来动态的渲染组件，当属性发生改变的时候，该组件将被销毁并重新创建。

```html
<svelte:component this={currentSelection.component} foo={bar}/>
```

如果`this`对应的值为`false`,则不回渲染组件。