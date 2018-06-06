import { flatten } from "../src/flatten";

describe("Test for flatting arrays", () => {
    it("[1, [2, [3]]] to flatten", () => {
        expect(flatten([1, [2, [3]]])).toEqual([1,2,3]);
    })
    it("Many levels of nesting", () => {
        expect(flatten(Array(2).fill(Array(2).fill(Array(2).fill([1]))))).toEqual([1,1,1,1,1,1,1,1]);
    })
    it("Different levels of nesting", () => {
        expect(flatten([1, [2], [[3]]])).toEqual([1,2,3]);
    })
})