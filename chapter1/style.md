### style

写在`<style>`中的CSS与组件外部是隔离的

这个功能是通过给元素添加带有组件style哈希的class来实现的。eg（svelte-123xyz）

可以通过使用`:global(...)`修饰符将样式作用域全局