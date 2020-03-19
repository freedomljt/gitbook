# Axios interceptor 中取消重复请求

在系统中，有这么一个业务场景，当用户搜索时，因没有做好防抖，所以用户每输入一个字符就发起一个异步请求，每个请求的返回时间顺序不可预估，导致最终的返回的结果不一定是最后一次查询的结果。

```javascript
// 创建对象
let doingRequest = {};

axios.interceptors.request.use(config => {
    // 增加参数配置控制是否启动取消机制，默认为true
    const { cancellation = true, method, url } = config;

    // 默认标记是请求方法+请求地址
    const mark = `${method}-${url}`;

    if (doingRequest[mark] && cancellation) {
        doingRequest[mark].cancel('Cancel the same request');
        delete doingRequest[mark];
    }

    doingRequest[mark] = axios.CancelToken.source();

    config.cancelToken = doingRequest[mark].token;

    return config;
});

axios.interceptors.response.use(response => {
    // do some response
}, error => {
    if (axios.isCancel(error)) {
        return Promise.reject(error);
    }
    // else do some status reject;
})

```