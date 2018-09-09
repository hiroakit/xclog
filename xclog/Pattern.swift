//
//  Pattern.swift
//  xclog
//
//  Copyright (c) 2017 Hiroaki ENDOH
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation

/// Regular Expression Pattern for Xcode build log
class Pattern {
    
    /// Get file name from file path
    ///
    /// - Note:
    /// ```
    /// Signing /Users/your/Library/Developer/Xcode/DerivedData/myTV-abc/Build/Intermediates.noindex/ArchiveIntermediates/myTV/IntermediateBuildFilesPath/UninstalledProducts/appletvos/myTV_TopShelf.appex
    /// ```
    /// ↓↓↓
    /// ```
    /// myTV_TopShelf.appex
    /// ```
    static let filename             = "([^\\/]*)$"
    
    static let analyzeTarget        = "^=== ANALYZE TARGET\\s(.*)\\sOF PROJECT\\s(.*)\\sWITH.*CONFIGURATION\\s(.*)\\s==="
    static let buildTarget          = "^=== BUILD TARGET\\s(.*)\\sOF PROJECT\\s(.*)\\sWITH.*CONFIGURATION\\s(.*)\\s==="
    static let cleanTarget          = "^=== CLEAN TARGET\\s(.*)\\sOF PROJECT\\s(.*)\\sWITH CONFIGURATION\\s(.*)\\s==="
    static let cleanRemove          = "^Clean.Remove"
    static let compile              = "^Compile[\\w]+\\s.+?\\s((?:\\.|[^ ])+\\/((?:\\\\.|[^ ])+\\.(?:m|mm|c|cc|cpp|cxx|swift)))"
    static let complieXib           = "^CompileXIB\\s(.*\\/([^\\/].*\\.xib))"
    static let complieStoryboard    = "^CompileStoryboard\\s(.*\\/([^\\/].*\\.storyboard))"
    static let compileWarning       = "^(\\/.+\\/(.*):.*:.*):\\swarning:\\s(.*)$"
    static let codeSign             = "^CodeSign\\s((?:\\ |[^ ])*)$"
    static let codeSignFramework    = "^CodeSign\\s((?:\\ |[^ ])*.framework)\\/Versions"
    static let cpResource           = "^CpResource\\s(.*)\\s\\/"
    static let generateDsym         = "^GenerateDSYMFile \\/.*\\/(.*\\.dSYM)"
    static let phaseScriptExecution = "^PhaseScriptExecution\\s((\\\\\\ |\\S)*)\\s"
    static let linking              = "^Ld \\/?.*\\/(.*?) (.*) (.*)$"
    static let phaseSuccess         = "^\\*\\*\\s(.*)\\sSUCCEEDED\\s\\*\\*"

    static let testSuiteStarted     = "^\\s*Test Suite '(.*)' started at"
    static let testSuiteRunStarted  = "^\\s*Test Suite '(?:.*\\/)?(.*[ox]ctest.*)' started at(.*)"
    static let testCasePassed       = "^\\s*Test Case\\s'-\\[(.*)\\s(.*)\\]'\\spassed\\s\\((\\d*\\.\\d{3})\\sseconds\\)"
    static let testCaseFailed       = "^\\s*(.+:\\d+):\\serror:\\s[\\+\\-]\\[(.*)\\s(.*)\\]\\s:(?:\\s'.*'\\s\\[FAILED\\],)?\\s(.*)"
}
