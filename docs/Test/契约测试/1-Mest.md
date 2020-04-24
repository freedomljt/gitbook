# Mest

```javascript
let mest = new Mest();
let resutls: IDiff = mest.localCompareInterface('FraudCheckResponse.ts', {
    status: FRAUD,
    rejectionReason: 'Amount too high'
});
expect(resutls).toEqual({
    diff: {
        local: ['fraudCheckStatus'],
        remote: ['status']
    }
})
```