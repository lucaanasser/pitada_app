#!/usr/bin/env python3
# ─────────────────────────────────────────────────────────────────────────────
# tool/spec_gate.py
# O QUÊ:     Portão das specs: (1) todo specs/**/*.yaml parseia como YAML;
#            (2) todo valor de chave `file:` aponta p/ um arquivo vivo no repo.
# USADO POR: verificação manual/CI antes de commit (python3 tool/spec_gate.py).
# ─────────────────────────────────────────────────────────────────────────────
import glob
import os
import sys

import yaml

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def collect_files(node, found):
    """Percorre o YAML e acumula todo valor de chave `file:` em `found`."""
    if isinstance(node, dict):
        for key, value in node.items():
            if key == 'file' and isinstance(value, str):
                found.append(value.strip())
            collect_files(value, found)
    elif isinstance(node, list):
        for item in node:
            collect_files(item, found)


def main():
    errors = []
    for path in sorted(glob.glob(os.path.join(ROOT, 'specs/**/*.yaml'), recursive=True)):
        rel = os.path.relpath(path, ROOT)
        try:
            data = yaml.safe_load(open(path))
        except yaml.YAMLError as exc:
            mark = getattr(exc, 'problem_mark', None)
            line = mark.line + 1 if mark else '?'
            errors.append(f'{rel}:{line} não parseia: {getattr(exc, "problem", exc)}')
            continue
        refs = []
        collect_files(data, refs)
        for ref in refs:
            if not os.path.exists(os.path.join(ROOT, ref)):
                errors.append(f'{rel}: file aponta p/ caminho morto: {ref}')
    if errors:
        print('\n'.join(errors))
        print(f'FALHOU: {len(errors)} problema(s)')
        return 1
    print('portão ok: specs parseiam e todo file: está vivo')
    return 0


if __name__ == '__main__':
    sys.exit(main())
