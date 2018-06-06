export function flatten(array: any[], result = []) {
    for (let i = 0, length = array.length; i < length; i++) {
        const value = array[i];
        if (Array.isArray(value)) {
            flatten(value, result);
        } else {
            result.push(value);
        }
    }
    return result;
}