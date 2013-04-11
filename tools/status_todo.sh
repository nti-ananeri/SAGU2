#!/bin/bash

base=$(dirname $0)
if [ $1 ]
then
	todo_path=$1
else
	todo_path=$base/../docs/todo.txt
fi

echo "Lendo TODO em $todo_path..."
echo

total_reservado_sem_prio=0
total_reservado_prio1=0
total_reservado_prio2=0
total_reservado_prio3=0
total_reservado=0
total_resolvido_sem_prio=0
total_resolvido_prio1=0
total_resolvido_prio2=0
total_resolvido_prio3=0
total_resolvido=0
for initial in D G
do
    reservado_sem_prio=$(grep "\[  \]\[${initial}\]\[ \]" $todo_path | wc -l)
    reservado_prio1=$(grep "\[  \]\[${initial}\]\[1\]" $todo_path | wc -l)
    reservado_prio2=$(grep "\[  \]\[${initial}\]\[2\]" $todo_path | wc -l)
    reservado_prio3=$(grep "\[  \]\[${initial}\]\[3\]" $todo_path | wc -l)
    reservado=$(($reservado_sem_prio+$reservado_prio1+$reservado_prio2+$reservado_prio3))

    total_reservado_sem_prio=$(($total_reservado_sem_prio+$reservado_sem_prio))
    total_reservado_prio1=$(($total_reservado_prio1+$reservado_prio1))
    total_reservado_prio2=$(($total_reservado_prio2+$reservado_prio2))
    total_reservado_prio3=$(($total_reservado_prio3+$reservado_prio3))
    total_reservado=$(($total_reservado+$reservado))

    resolvido_sem_prio=$(grep "\[[oO][kK]\]\[${initial}\]\[ \]" $todo_path | wc -l)
    resolvido_prio1=$(grep "\[[oO][kK]\]\[${initial}\]\[1\]" $todo_path | wc -l)
    resolvido_prio2=$(grep "\[[oO][kK]\]\[${initial}\]\[2\]" $todo_path | wc -l)
    resolvido_prio3=$(grep "\[[oO][kK]\]\[${initial}\]\[3\]" $todo_path | wc -l)
    resolvido=$(($resolvido_sem_prio+$resolvido_prio1+$resolvido_prio2+$resolvido_prio3))

    total_resolvido_sem_prio=$(($total_resolvido_sem_prio+$resolvido_sem_prio))
    total_resolvido_prio1=$(($total_resolvido_prio1+$resolvido_prio1))
    total_resolvido_prio2=$(($total_resolvido_prio2+$resolvido_prio2))
    total_resolvido_prio3=$(($total_resolvido_prio3+$resolvido_prio3))
    total_resolvido=$(($total_resolvido+$resolvido))

    echo "Tarefas de ${initial}:"
    printf "       Reservados: %3d (Sem prio: %3d | Prio 1: %3d | Prio 2: %3d | Prio 3: %3d)\n" $reservado $reservado_sem_prio $reservado_prio1 $reservado_prio2 $reservado_prio3
    printf "       Resolvidos: %3d (Sem prio: %3d | Prio 1: %3d | Prio 2: %3d | Prio 3: %3d)\n" $resolvido $resolvido_sem_prio $resolvido_prio1 $resolvido_prio2 $resolvido_prio3
done

pendente_sem_prio=$(grep "\[  \]\[ \]\[ \]" $todo_path | wc -l)
pendente_prio1=$(grep "\[  \]\[ \]\[1\]" $todo_path | wc -l)
pendente_prio2=$(grep "\[  \]\[ \]\[2\]" $todo_path | wc -l)
pendente_prio3=$(grep "\[  \]\[ \]\[3\]" $todo_path | wc -l)
pendente=$(($pendente_sem_prio+$pendente_prio1+$pendente_prio2+$pendente_prio3))

echo
printf "Total sem reserva: %3d (Sem prio: %3d | Prio 1: %3d | Prio 2: %3d | Prio 3: %3d)\n" $pendente $pendente_sem_prio $pendente_prio1 $pendente_prio2 $pendente_prio3
printf "Total reservado:   %3d (Sem prio: %3d | Prio 1: %3d | Prio 2: %3d | Prio 3: %3d)\n" $total_reservado $total_reservado_sem_prio $total_reservado_prio1 $total_reservado_prio2 $total_reservado_prio3
printf "Total resolvido:   %3d (Sem prio: %3d | Prio 1: %3d | Prio 2: %3d | Prio 3: %3d)\n" $total_resolvido $total_resolvido_sem_prio $total_resolvido_prio1 $total_resolvido_prio2 $total_resolvido_prio3

total_tarefas=$(($total_reservado+$total_resolvido+$pendente))

echo
printf "Total de tarefas: %4d\n" $total_tarefas
echo

