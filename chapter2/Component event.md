## Component events

```html
on:eventname={handler}
```

组件可以使用`createEventDispatcher`或转发 DOM 事件来 emit 事件。监听组件事件看起来与监听 DOM 事件一样：

```html
<SomeComponent on:whatever={handler}/>
```

和 DOM 事件一样，如果使用`on：`指令而没有值，则组件将转发事件，这意味着组件的使用者可以监听这个事件。

```html
<SomeComponent on:whatever/>
```

