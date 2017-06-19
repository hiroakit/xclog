//
//  Simple.swift
//  xclog
//
//  Copyright (c) 2017 Hiroaki ENDOH
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation

class Simple {
    func formatCleanTarget(target: String, project: String, configuration: String) -> String {
        return "Cleaning \(project)/\(target) \(configuration)"
    }

    func formatBuildTarget(target: String, project: String, configuration: String) -> String {
        return "Building \(project)/\(target) \(configuration)"
    }

    func formatAnalyzeTarget(target: String, project: String, configuration: String) -> String {
        return "Analyzing \(project)/\(target) \(configuration)"
    }

    func formatCompile(fileName: String) -> String {
        return "Compiling \(fileName)"
    }

    func formatCompileXib(fileName: String) -> String {
        return "Compiling \(fileName)"
    }

    func formatCompileStoryboard(fileName: String) -> String {
        return "Compiling \(fileName)"
    }

    func formatCpResource(resource: String) -> String {
        return "Copying \(resource)"
    }

    func formatCodeSign(fileName: String) -> String {
        return "Signing \(fileName)"
    }

    func formatGenerateDsym(fileName: String) -> String {
        return "Generating \(fileName)"
    }

    func formatPhaseScriptExecution(scriptName: String) -> String {
        return "Running script \(scriptName)"
    }

    func formatLinking(target: String, buildVariants: String, arch: String) -> String {
        return "Linking \(target)"
    }

    func formatWarning(message: String) -> String {
        return "\t Warning \(message)"
    }

    func formatPhaseSuccess(phaseName: String) -> String {
        let str = phaseName.capitalized
        return "\(str) Succeeded"
    }

    func formatTestRunStarted(name: String) -> String {
        return "Test Suite \(name) started"
    }

    func formatTestSuiteStarted(name: String) -> String {
        return "\(name)"
    }

    func formatTestCasePassed(suite: String, testCase: String, time: String) -> String {
        return "\t Passed \(testCase) \(time)seconds"
    }

    func formatTestCaseFailed(suite: String, testCase: String, time: String) -> String {
        return "\t Failed \(testCase)"
    }

}
