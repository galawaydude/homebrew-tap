class AgentSwitch < Formula
  desc "Run Claude Code on several subscriptions from one machine"
  homepage "https://github.com/galawaydude/agent-switch"
  url "https://github.com/galawaydude/agent-switch/releases/download/v0.4.0/agent-switch-0.4.0.tgz"
  sha256 "88280f8ad44b11a42a8d133714cd5d9a3edc6460efc244cead806691ea23d4ad"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Connect `claude` in your terminal, then open the page:
        agent-switch setup
        agent-switch ui
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-switch --version")
    ENV["AGENT_SWITCH_STATE_DIR"] = testpath/"state"
    assert_match "claude()", shell_output("#{bin}/agent-switch shell-init bash")
    assert_match "Main", shell_output("#{bin}/agent-switch list")
  end
end
