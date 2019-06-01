### Classes
```
class:name={value}
```
```
class:name
```
这种 `class:` 指令提供了一个更便捷的方式来切换元素上的 `class`。
```html
<!-- These are equivalent -->
<div class="{active ? 'active' : ''}">...</div>
<div class:active={active}>...</div>

<!-- Shorthand, for when name and value match -->
<div class:active>...</div>

<!-- Multiple class toggles can be included -->
<div class:active class:inactive={!active} class:isAdmin>...</div>
```