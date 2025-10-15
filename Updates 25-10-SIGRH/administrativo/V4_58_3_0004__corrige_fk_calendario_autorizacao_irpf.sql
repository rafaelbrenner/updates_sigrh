-- 445193 - Autorização de acesso a Declaração do IRPF

alter table financeiro.autorizacao_acesso_irpf drop constraint id_calendario_fkey;

alter table financeiro.autorizacao_acesso_irpf
add constraint autorizacao_acesso_irpf_id_calendario_fkey foreign key (id_calendario)
references financeiro.calendario_autorizacao_irpf(id_calendario);