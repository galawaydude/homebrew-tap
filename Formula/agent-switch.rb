class AgentSwitch < Formula
  desc "Run Claude Code on several subscriptions from one machine"
  homepage "https://github.com/galawaydude/agent-switch"
  url "https://github.com/galawaydude/agent-switch/releases/download/v0.1.0/agent-switch-0.1.0.tgz"
  sha256 "5ac704836faa4a9e3a3a29969ff36a336e2c7377b258cc3d30527c7dfc146d5b"
  license "MIT"

  depends_on :linux
  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      To make `claude` start as the account you pick, add this to your shell rc:
        eval "$(agent-switch shell-init)"
      Then check the setup with:
        agent-switch doctor
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-switch --version")
    ENV["AGENT_SWITCH_STATE_DIR"] = testpath/"state"
    assert_match "claude()", shell_output("#{bin}/agent-switch shell-init bash")
    assert_match "Main", shell_output("#{bin}/agent-switch list")
  end
end
