require 'rubygems'
require 'bundler'
require 'tty-prompt'
require 'require_all'
require 'json'

Bundler.setup(:default, :development)

require_rel 'lib/errors'
require_rel 'lib/command_loader'
require_rel 'lib/data_store'
require_rel 'lib/search_engine'
require_rel 'lib/zen_search'

prompter = TTY::Prompt.new
commands_dir = File.join(File.dirname(__FILE__), 'lib', 'commands')
commands = CommandLoader.new(commands_dir).load!
data_store = DataStore.new

zen_search = ZenSearch.new(prompter, $stdout, commands, data_store)

welcome_message = <<EOS

        O$- >$$
       OOOO.OOO:      ;QQQQQQQ                   QQQQQO                                  !Q
       $OOOO.OOC            QQ                  ?Q?  QQ                                  !Q
      ;! :OO OO?;          QQ                   QQ                                       !Q
    .OOO:  C    OO-       QQ    >QQQC   Q-QQQC  QQC        QQQQ     QQQ!QQ >Q QQ   QQQ$  !Q QQQ.
    ?OOO       COO7       Q7   :QQ!QQ7  QQ$>QQ!  QQQQ     QQ7?QQ   QQO$QQQ >QQQQ  QQ$QQQ !QQ$>QQ
     OC        OOO       QQ    Q:   ;Q  QQ   QQ   .QQQC  QQ    Q: QQ    QQ >Q$   QQ    Q.!Q?   QO
     :;O:      OO       CQ     QQQQQQQ  Q>   QQ      QQ  QQQQQQQQ QQ    QQ >Q    Q$      !Q    QQ
      OO$.      !      ;QO     Q::::::  Q:   QQ       QQ Q!:::::: QQ    QQ >Q    Q$      !Q    QQ
     ?OO>$O -OOOO;     QQ      Q:       Q:   QQ QQ   :Q! QQ       QQ    QQ >Q    QQ   .Q:!Q    QQ
     COO.$OC7OOOO:    $QQQQQQQ >QQ>QQ$  Q:   QQ QQQQQQQ   QQ?CQQ   QQCQQQQ >Q     QQ$QQQ !Q    QQ
     .O$:$OO! O$C     $QQQQQQQ  7QQQ$   Q:   QQ  :QQQQ     QQQQ     QQQ-QQ >Q      QQQ$  !Q    QQ
          OOO
          .O;

Welcome to ZenSearch!
EOS
puts welcome_message

zen_search.run
