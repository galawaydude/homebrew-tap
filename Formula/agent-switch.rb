class AgentSwitch < Formula
  desc "Run Claude Code on several subscriptions from one machine"
  homepage "https://github.com/galawaydude/agent-switch"
  url "https://github.com/galawaydude/agent-switch/releases/download/v0.3.0/agent-switch-0.3.0.tgz"
  sha256 "69226023f93efe0e4a4a185351f4f6345b98b3a1809e789cb06bb9d84895be0c"
  license "MIT"

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
