import * as complexity from "../src/complexity";

function generateArray(l: number): number[] {
    return Array.apply(null, {length: l}).map(Number.call, Number)
}

describe("Test isZero", () => {
    it("Test if 0 isZero", () => {
        expect(complexity.isZero(0)).toBeTruthy();
    })
    it("Test if 1 isZero is false", () => {
        expect(complexity.isZero(1)).toBeFalsy();
    })
})

describe("Test for contains", () => {
    it("5 is in [0..9]", () => {
        const list = generateArray(10);
        expect(complexity.contains(list, 5)).toBeTruthy();
    })
    it("10 is not in [0,9]", () => {
        const list = generateArray(10);
        expect(complexity.contains(list, 10)).toBeFalsy();
    })
})