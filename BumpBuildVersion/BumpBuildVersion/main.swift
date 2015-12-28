#!/usr/bin/swift

import Foundation

struct Constants {
    static let gitPath = "/usr/bin/git"
    static let agvtoolPath = "/usr/bin/agvtool"
}

struct GitUtility {
    func tagBranchWithTagName(tagName: String) -> String? {
        return executeGitCommandWithArguments("tag " + tagName.stringByTrimmingWhitespaceAndNewline())
    }

    func createBranchNamed(branchName: String) {
        executeGitCommandWithArguments("branch " + branchName)
    }

    func deleteBranchNamed(branchName: String) {
        executeGitCommandWithArguments("branch -D " + branchName)
    }

    func switchToBranchNamed(branchName: String) {
        executeGitCommandWithArguments("checkout " + branchName)
    }

    func currentGitBranch() -> String? {
        return executeGitCommandWithArguments("rev-parse --abbrev-ref HEAD")?.stringByTrimmingWhitespaceAndNewline()
    }

    // MARK: private

    private func executeGitCommandWithArguments(arguments: String) -> String? {
        let taskExecutor = OSTaskExecutor()
        return taskExecutor.systemCommandWithLaunchPath(Constants.gitPath, arguments:arguments).0
    }
}

struct VersionStringTransformer {
    func nextBranchName(branchName: String) -> String {
        return nextMajorMinorInternalVersion(branchName, separator: "_")
    }

    func nextBuildVersionNumber(version: String) -> String {
        return nextMajorMinorInternalVersion(version, separator: ".")
    }

    // MARK: private

    private func nextMajorMinorInternalVersion(version: String, separator: Character) -> String {
        assert(version.characters.count > 0)

        var nextVersionString = version
        var versionComponents = version.stringByTrimmingWhitespaceAndNewline().characters.split{$0 == separator}.map(String.init)

        if let lastVersionComponent = versionComponents.last {
            let lastNumber = Int(lastVersionComponent)

            if let safeLastNumber = lastNumber {
                let nextVersionNumber = Int(safeLastNumber + 1)

                let lastIndex = (versionComponents.count - 1)
                versionComponents[lastIndex] = String(nextVersionNumber)
            }
            nextVersionString = versionComponents.joinWithSeparator(String(separator))
        }
        return nextVersionString
    }
}

func tagNameFromBranchName(branchName: String) -> String {
    let safeBranchName = branchName.stringByTrimmingWhitespaceAndNewline()
    return String(safeBranchName.characters.dropFirst())
}

func executeArgvtoolWithArguments(arguments: String) -> String? {
    return OSTaskExecutor().systemCommandWithLaunchPath(Constants.agvtoolPath, arguments: arguments).0
}

func bumpBuildVersionNumber() {
    if let currentBuildVersionNumber = executeArgvtoolWithArguments("what-version -terse") {
        let nextBuildVersionNumber = VersionStringTransformer().nextBuildVersionNumber(currentBuildVersionNumber)
        executeArgvtoolWithArguments("new-version -all " + nextBuildVersionNumber)
    }
}

func main() {
    let gitUtility = GitUtility()
    let branch = gitUtility.currentGitBranch()

    if let currentBranch = branch {
        gitUtility.tagBranchWithTagName(tagNameFromBranchName(currentBranch))

        let newBranchName = VersionStringTransformer().nextBranchName(currentBranch)
        gitUtility.createBranchNamed(newBranchName)
        gitUtility.switchToBranchNamed(newBranchName)

        let oldBranchName = currentBranch
        gitUtility.deleteBranchNamed(oldBranchName)

        bumpBuildVersionNumber()

        print("\nCurrently the script only places a tag in the repo")
        print("Things on the list to implement:")
        print("\t- missing unit tests")
        print("\t- abort execution if there are local changes in the repo (you don't want to release if there are some local changes!)")
        print("\t- automatically make a commit updating version number in the info.plist file")
        print("\t- print more verbose information about what's happening behind the scenes")
    }
}
main();
