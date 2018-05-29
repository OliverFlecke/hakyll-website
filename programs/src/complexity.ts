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

export { isZero, contains };