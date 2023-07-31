# https://tech.medpeer.co.jp/entry/2023-small-rbs-introduce
D = Steep::Diagnostic
target :app do
  signature 'sig'

  check 'app'

  # 型検査はせずに補完強化用途でのみSteepを利用する
  # configure_code_diagnostics do |hash|
  #   D::Ruby::ALL.each do |error|
  #     hash[error] = nil
  #   end
  # end

  # https://github.com/soutaro/steep/pull/800 の対応がリリースされたら↓に書き換えること
  # configure_code_diagnostics(D::Ruby.silent)
end
