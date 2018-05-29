function insertSort(list: any[]): any[] {
    let i = 0;
    while (i < list.length) {
        let j = i;
        while (j > 0 && list[j-1] > list[j]) {
            let temp = list[j];
            list[j] = list[j-1];
            list[j-1] = temp;
            j--;
        }
        i++;
    }
    return list;
}

export { insertSort };