## 组件事件

```html
on:eventname={handler}
```

组件可以通过`createEventDispatcher` 方法触发一个事件。

监听组件的事件，和监听 html 事件一模一样。

```html
<SomeComponent on:whatever={handler}/>
```

和 DOM 事件一样，如果 `on:` 指令，后面没有指定事件回调函数。意味着，这个组件的消费者，将会监听这个事件。

```html
<SomeComponent on:whatever/>
```

