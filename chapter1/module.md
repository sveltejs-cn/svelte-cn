### &lt;script content="module"&gt;

一个带有`context="module"`属性的`<script>`标签的模块只会执行一次，而不是每次都生成组件实例。在此模块中申明的Values可以被正常的`<script>`标签访问到（包括组件标签）但是反之则无法这么使用。

你可以从此区块中 导出 这些绑定值，并且他们会成为编译的模块的导出值

你不能 export default 因为默认导出的是组件本身