# Nodejs

NodeJs 是一个基于 Chrome V8 JavaScript 引擎构建的 JavaScript 运行时

使用 `Libuv` (跨平台的异步 IO 库) 适配各个操作系统下的适配

## 多线程支持

NodeJs 在 V10.5.0 提供多线程支持，但每个线程拥有自己独立的堆，通过消息进行通讯

```javascript
const {
  Worker,
  isMainThread,
  parentPort,
  workerData,
} = require("worker_threads");

if (isMainThread) {
  // __filename 为当前运行的js文件路径
  const worker = new Worker(__filename, { workerData: { num: 5 } });
  worker.once("message", (result) => {
    console.log("square of 5 is :", result);
  });
} else {
  parentPort.postMessage(workerData.num * workerData.num);
}
```

不仅 NodeJs 中支持了多线程，浏览器中也支持了多线程: [https://microsoft.github.io/monaco-editor/playground.html](https://microsoft.github.io/monaco-editor/playground.html)

## 异步 IO

很久(ES6)以前...

```javascript
//通过回进行异步 IO
getRemoteData("xxxx", callback);

//链路一长就容易掉入回调地狱
getRemoteData1("xxxx", (data1) =>
  getRemoteData2(data1, (data2) =>
    getRemoteData3(data2, ...))
);
```

现代写法(Promise)

```javascript
const getRemoteDataWithPromise = (params) =>
  new Promise((resolve, reject) => {
    getRemoteData(params, resolve);
  });
```

```javascript
getRemoteDataWithPromise1("xxxx")
.then(data => getRemoteDataWithPromise2(data))
.then(data => getRemoteDataWithPromise3(data))
...
```

async await 写法

```javascript
let data1 = await getRemoteDataWithPromise1("xxxx");
let data2 = await getRemoteDataWithPromise2(data1);
let data3 = await getRemoteDataWithPromise3(data2);
...
```

多个请求并行发送

```javascript
let [data1, data2, data3] = await Promise.all([
  getRemoteDataWithPromise1(),
  getRemoteDataWithPromise2(),
  getRemoteDataWithPromise3(),
]);
```

很急，不想一个个的等

按从左到右顺序

```javascript
for await (let result of [
  getRemoteDataWithPromise1(),
  getRemoteDataWithPromise2(),
  getRemoteDataWithPromise3(),
]) {
  console.log(result);
}
```

按返回先后顺序

```javascript
[
  getRemoteDataWithPromise1(),
  getRemoteDataWithPromise2(),
  getRemoteDataWithPromise3(),
].forEach((task) => task.then((result) => console.log(result)));
```

多个请求并行发送取第一个成功的进行返回

```javascript
let data = await Promise.any([
  getRemoteDataWithPromise1(),
  getRemoteDataWithPromise2(),
  getRemoteDataWithPromise3(),
]);
```

await 支持 try-catch

```javascript
try {
  await getRemoteDataWithPromise1();
} catch (e) {
  console.log(e);
}
```

await 也支持返回非 Promise 的方法，相当于不使用 await

## 结构赋值

数组

```javascript
let [a, b, c] = ["x", "y", "z"];

console.log(a, b, c);
// 'x', 'y', 'z'
```

对象

```javascript
let obj = { a: "x", b: "y", c: "z" };
let { a, b, c } = obj;
console.log(a, b, c);
// 'x', 'y', 'z'
```

混合起来用

```javascript
let [a, { name }, b] = ["x", { name: "张三" }, "y"];
console.log(a, name, b);
// 'x', '张三', 'z'
```

名称冲突解决

```javascript
let [{name: name1}, {name: name2}] = [{name: '张三'}, {name: "李四"}]
console.log(name1, name2);
// '张三', '李四'
```

...语法

```javascript
let [a, ...b] = ["x", "y", "z"];

console.log(a, b);
// 'x', ['y', 'z']
````

```javascript
let { k1, k2, kx = 1, ...ks } = { k1: "x", k2: "y", k3: "z", k4: "a" };

console.log(k1, k2, kx, ks);
// 'x', 'y', 1, {k3: 'z', k4: 'a'}
// kx = 1, 右边对 kx 赋值了就用右边的，没有的话 kx = 1
```

合并数组

```javascript
let a = [1, 2, 3];
let b = [4, 5, 6];
let c = [0, ...a, "x", ...b, "z"];
console.log(c);
// [0,1,2,3,'x',4,5,6,'z']
```

合并对象

```javascript
let o1 = { a: 1, b: 2 };
let o2 = { c: 3, b: 4 };
let o3 = { ...o1, ...o2, d: 5 };
console.log(o3);
// 属性冲突时写后面的属性覆盖前面的属性
// {a: 1, c: 3, b: 4, d: 5}
```

## 方法重载

js 不支持方法重载，调用法多传的参数会被忽略，被调用方没有收到的参数会被当成 undefined 处理

## 防空指针

```javascript
let a = obj?.f1?.[1]?.m1?.();
```

## 字符串模板

```javascript
let a = 11;
let b = 12;

console.log(`${a}+${b}=${a + b}`);
// 11+12=23
```
