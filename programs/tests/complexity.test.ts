import { isZero, contains, fibonacci} from "../src/complexity";

function generateArray(l: number): number[] {
    return Array.apply(null, {length: l}).map(Number.call, Number)
}

describe("Test isZero", () => {
    it("Test if 0 isZero", () => {
        expect(isZero(0)).toBeTruthy();
    })
    it("Test if 1 isZero is false", () => {
        expect(isZero(1)).toBeFalsy();
    })
})

describe("Test for contains", () => {
    it("5 is in [0..9]", () => {
        const list = generateArray(10);
        expect(contains(list, 5)).toBeTruthy();
    })
    it("10 is not in [0,9]", () => {
        const list = generateArray(10);
        expect(contains(list, 10)).toBeFalsy();
    })
})

describe("Test fibonacci number generation", () => {
    it("The 0th fibonacci number should be 0", () => {
        expect(fibonacci(0)).toBe(0);
    })
    it("The 1st fibonacci number should be 1", () => {
        expect(fibonacci(1)).toBe(1);
    })
    it("The 2nd fibonacci number should be 1", () => {
        expect(fibonacci(2)).toBe(1);
    })
    it("The 3rd fibonacci number should be 3", () => {
        expect(fibonacci(3)).toBe(2);
    })
    it("The 4th fibonacci number should be 3", () => {
        expect(fibonacci(4)).toBe(3);
    })
    it("The 5th fibonacci number should be 5", () => {
        expect(fibonacci(5)).toBe(5);
    })
    it("The 6th fibonacci number should be 8", () => {
        expect(fibonacci(6)).toBe(8);
    })
    it("The 12th fibonacci number should be 144", () => {
        expect(fibonacci(12)).toBe(144);
    })
})