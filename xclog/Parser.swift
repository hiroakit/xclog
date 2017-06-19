//
//  Parser.swift
//  xclog
//
//  Copyright (c) 2017 Hiroaki ENDOH
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation

class Parser {

    let formatter: Simple

    init() {
        self.formatter = Simple()
    }

    func parse(text: String) -> String {
        var result: String = ""

        if isMatch(text: text, pattern: Pattern.compileWarning) {
            let groups = text.capturedGroups(withRegex: Pattern.compileWarning)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatWarning(message: "\(groups[0]):\(groups[2])" )
        }

        if isMatch(text: text, pattern: Pattern.compile) {
            let groups = text.capturedGroups(withRegex: Pattern.compile)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatCompile(fileName: groups[1])
        }
        else if isMatch(text: text, pattern: Pattern.complieXib) {
            let groups = text.capturedGroups(withRegex: Pattern.complieXib)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatCompileXib(fileName: groups[1])
        }
        else if isMatch(text: text, pattern: Pattern.complieStoryboard) {
            let groups = text.capturedGroups(withRegex: Pattern.complieStoryboard)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatCompileStoryboard(fileName: groups[1])
        }
        else if isMatch(text: text, pattern: Pattern.generateDsym) {
            let groups = text.capturedGroups(withRegex: Pattern.generateDsym)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatGenerateDsym(fileName: groups[0])
        }
        else if isMatch(text: text, pattern: Pattern.cleanTarget) {
            let groups = text.capturedGroups(withRegex: Pattern.cleanTarget)
            guard groups.count > 0 else {
                return result
            }
            result = self.formatter.formatCleanTarget(target: groups[0], project: groups[1], configuration: groups[2])
        }
        else if isMatch(text: text, pattern: Pattern.buildTarget) {
            let groups = text.capturedGroups(withRegex: Pattern.buildTarget)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatBuildTarget(target: groups[0], project: groups[1], configuration: groups[2])
        }
        else if isMatch(text: text, pattern: Pattern.cleanRemove) {
            result = ""
        }
        else if isMatch(text: text, pattern: Pattern.analyzeTarget) {
            let groups = text.capturedGroups(withRegex: Pattern.analyzeTarget)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatAnalyzeTarget(target: groups[0], project: groups[1], configuration: groups[2])
        }
        else if isMatch(text: text, pattern: Pattern.codeSign) {
            let groups = text.capturedGroups(withRegex: Pattern.codeSign)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatCodeSign(fileName: groups[0])
        }
        else if isMatch(text: text, pattern: Pattern.codeSignFramework) {
            let groups = text.capturedGroups(withRegex: Pattern.codeSignFramework)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatCodeSign(fileName: groups[0])
        }
        else if isMatch(text: text, pattern: Pattern.phaseScriptExecution) {
            let groups = text.capturedGroups(withRegex: Pattern.phaseScriptExecution)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatPhaseScriptExecution(scriptName: groups[0])
        }
        else if isMatch(text: text, pattern: Pattern.linking) {
            let groups = text.capturedGroups(withRegex: Pattern.linking)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatLinking(target: groups[0], buildVariants: "", arch: "")
        }
        else if isMatch(text: text, pattern: Pattern.cpResource) {
            let groups = text.capturedGroups(withRegex: Pattern.cpResource)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatCpResource(resource: groups[0])
        }
        else if isMatch(text: text, pattern: Pattern.testSuiteRunStarted) {
            let groups = text.capturedGroups(withRegex: Pattern.testSuiteRunStarted)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatTestRunStarted(name: groups[0])
        }
        else if isMatch(text: text, pattern: Pattern.testSuiteStarted) {
            let groups = text.capturedGroups(withRegex: Pattern.testSuiteStarted)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatTestSuiteStarted(name: groups[0])
        }
        else if isMatch(text: text, pattern: Pattern.testCasePassed) {
            let groups = text.capturedGroups(withRegex: Pattern.testCasePassed)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatTestCasePassed(suite: groups[0], testCase: groups[1], time: groups[2])
        }
        else if isMatch(text: text, pattern: Pattern.testCaseFailed) {
            let groups = text.capturedGroups(withRegex: Pattern.testCaseFailed)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatTestCaseFailed(suite: groups[0], testCase: groups[1], time: groups[2])
        }
        else if isMatch(text: text, pattern: Pattern.phaseSuccess) {
            let groups = text.capturedGroups(withRegex: Pattern.phaseSuccess)
            guard groups.count > 0 else {
                return result
            }

            result = self.formatter.formatPhaseSuccess(phaseName: groups[0])
        }
        return result
    }

    private func isMatch(text: String, pattern: String) -> Bool {
        let options = String.CompareOptions.regularExpression
        let locale = Locale.current

        let range = text.range(of: pattern, options: options, range: nil, locale: locale)
        guard (range != nil) else {
            return false
        }

        return true
    }
}

extension String {
    func capturedGroups(withRegex pattern: String) -> [String] {
        var results = [String]()

        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }

        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.characters.count))

        guard let match = matches.first else { return results }

        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }

        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.rangeAt(i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }

        return results
    }
}
