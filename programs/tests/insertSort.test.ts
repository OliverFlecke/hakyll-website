import { insertSort } from "../src/insertSort";

describe("Test insert sort", () => {
    it("Sort empty list", () => {
        expect(insertSort([])).toEqual([]);
    })

    it("Sorting [3,2,1]", () => {
        const list = [3, 2, 1];
        expect(insertSort(list)).toEqual([1,2,3]);
    })
});
