mkdir ~/quiz-1

# Υπολογισμός single digit sum
N=10753
sum=0
while [ \$N -gt 9 ]; do
    sum=0
    while [ \$N -gt 0 ]; do
        sum=\$((sum + N % 10))
        N=\$((N / 10))
    done
    N=\$sum
done
echo "Single digit sum: \$N"

# Δημιουργία τυχαίας λέξης
randomword=\$(cat /dev/urandom | tr -dc 'a-z' | fold -w 6 | head -n 1)
echo "Random word: \$randomword"
# Δημιουργία αρχείων
num_files=\$((10 + N))
for i in \$(seq 1 \$num_files); do
    touch ~/quiz-1/\$randomword-\$i.txt
done
# Γέμισμα αρχείων με τυχαίες λέξεις
words=("super" "spider" "bat")
for i in \$(seq 1 \$num_files); do
    word_count=\$((N + 10))
    file_path=~/quiz-1/\$randomword-\$i.txt
    > \$file_path

    for _ in \$(seq 1 \$word_count); do
        echo -n "\${words[\$RANDOM % 3]} " >> \$file_path
    done
done

# Δημιουργία report.txt
report_path=~/quiz-1/report.txt
> \$report_path
for i in \$(seq 1 \$num_files); do
    file_path=~/quiz-1/\$randomword-\$i.txt
    super_count=\$(grep -o "super" \$file_path | wc -l)
    spider_count=\$(grep -o "spider" \$file_path | wc -l)
    bat_count=\$(grep -o "bat" \$file_path | wc -l)

    echo "\$file_path" >> \$report_path
    echo "\$super_count super" >> \$report_path
    echo "\$spider_count spider" >> \$report_path
    echo "\$bat_count bat" >> \$report_path
    echo "" >> \$report_path
done
EOF
