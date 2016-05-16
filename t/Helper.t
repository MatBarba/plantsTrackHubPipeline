
use Test::More;
use Test::File;
use Devel::Cover;

# -----
# checks if the module can load
# -----

#test1
use_ok(Helper);  # it checks if it can use the module correctly

# -----
# test run_system_command method
# -----

#test2
my $cmd = "touch ./electra";
my $exit_code = Helper::run_system_command ($cmd);
is($exit_code,1,'Check of successful system command run for method run_system_command');

#test3
file_exists_ok(("./electra"),"Check if the file I created exists");

#test4
my $cmd_wrong = "bla";
my $exit_code_wrong = Helper::run_system_command ($cmd_wrong);
is($exit_code_wrong,0,'Check of unsuccessful system command run returns 0');


# -----
# test run_system_command_with_output method
# -----

#test5
my $cmd_again = "ls";
my ($exit_code2,$output) = Helper::run_system_command_with_output ($cmd_again);
is($exit_code2,1,'Check of successful system command run of method run_system_command_with_output');

#test6
like($output,qr/electra/,'Check if \'ls\' command returns the previously made file');

Helper::run_system_command ("rm ./electra");


#test7
my $cmd_wrong2 = "blabla";
my ($exit_code_wrong2,$output2) = Helper::run_system_command_with_output ($cmd_wrong2);
is($exit_code_wrong2,0,'Check of unsuccessful system command run returns 0');

is($output2,'','Checks if output of wrong command is null');


#test8
Helper::run_system_command ("mkdir ./my_empty_dir");
my ($exit_code3,$output3) = Helper::run_system_command_with_output ("ls ./my_empty_dir");
is($exit_code3,1,'Check of successful system command run for method run_system_command_with_output');

#test9
is($output3,'','Checks if output of \'ls\' on an empty dir is null');

Helper::run_system_command ("rm -r ./my_empty_dir");

done_testing();