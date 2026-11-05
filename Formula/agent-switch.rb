class AgentSwitch < Formula
  desc "Run Claude Code on several subscriptions from one machine"
  homepage "https://github.com/galawaydude/agent-switch"
  url "https://github.com/galawaydude/agent-switch/releases/download/v0.2.0/agent-switch-0.2.0.tgz"
  sha256 "53f397f7c6349ad35b8c5082f3127d161149b1db915e25ca119501c4ed4afd13"
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
