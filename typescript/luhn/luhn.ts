export function valid(digitString: string): boolean {
    const ret = isValid(digitString);
    if (!ret) return ret;
    const norm = digitString.replaceAll(" ", "");
    let digitSum = 0;
    for (let i = norm.length - 2; i >= 0; i = i - 2) {
        const char = norm[i];
        let doubled = Number.parseInt(char) * 2
        if (doubled > 9) doubled -= 9;
        digitSum += doubled;
    }

    for (let i = norm.length - 1; i >= 0; i = i - 2) {
        const char = norm[i]
        digitSum += Number.parseInt(char)
    }

    return digitSum % 10 === 0

}

function isValid(digitString: string): boolean {
    digitString = digitString.replaceAll(" ", "");
    if (digitString.length <= 1) return false;
    for (let c of digitString) {
        if (!c.match("[1234567890]")) {
            return false;
        }
    }

    return true;
}
