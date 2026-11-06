class AgentSwitch < Formula
  desc "Run Claude Code on several subscriptions from one machine"
  homepage "https://github.com/galawaydude/agent-switch"
  url "https://github.com/galawaydude/agent-switch/releases/download/v0.5.0/agent-switch-0.5.0.tgz"
  sha256 "c4c71ef63e8765eb705c30b606817bb33c20ff4af7aa114ac3c4067acda9af09"
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
