function isZero(value: number): boolean {
    return value === 0;
}

function contains(list: any[], x: any): boolean {
    for (let i = 0; i < list.length; i++) {
        if (list[i] === x) {
            return true;
        }
    }
    return false;
}

function fibonacci(n: number): number {
    if (n <= 0) return 0;
    if (n <= 2) return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

export { isZero, contains, fibonacci };