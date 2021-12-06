#
# Generate the needed icons from a set of originals
#
# Copyright (c) 2021 Keith Pinson

# Can be called with something like:
#
#    python icons_copy_to_apps.py
#        --base ..\..
#        --originals ..\icon_originals
#        --generated ..\icons_generated
#        --csv app_icon_checklist.csv

import os
import sys
import argparse
import csv
import shutil
from PIL import Image


def read_csv(csv_file):

    fields = []
    rows = []

    with open(csv_file, newline='') as f:
        reader = csv.reader(f)

        try:
            fields = next(reader)

            for row in reader:
                rows.append(row)

        except csv.Error as e:
            sys.exit('file {}, line {}: {}'.format(
                f, reader.line_num, e))

    # print('Fields: ' + ', '.join(field for field in fields))

    # print('\nFirst 5 rows:\n')
    # for row in rows[:5]:
    #     for col in row:
    #         print("%10s" % col, end=''),
    #     print('\n')

    return fields, rows


def generate_icon(fields, row, originals_path, generated_path, copy_to_apps, base):

    project_base = os.path.abspath(base)

    icon_size_index = fields.get("Icon Size")
    from_size_index = fields.get("From Size")
    original_index = fields.get("Original")
    extension_index = fields.get("Extension")
    copy_name_index = fields.get("Copy Name")

    icon_size = row[icon_size_index] if icon_size_index is not None else ""
    from_size = row[from_size_index] if from_size_index is not None else ""
    extension = row[extension_index] if extension_index is not None else "png"
    copy_name = row[copy_name_index] if copy_name_index is not None else None

    original = True if original_index and row[original_index] == "1" else False

    if original or icon_size == from_size:
        copy_original = True
    else:
        copy_original = False

    original_file_path = os.path.join(
        originals_path, from_size + '.' + extension)
    generated_file_path = os.path.join(
        generated_path, icon_size + '.' + extension)

    if not os.path.isfile(original_file_path):
        print("Original icon file not found:", original_file_path)
    else:
        if copy_original:
            # if original then copy
            shutil.copyfile(original_file_path, generated_file_path)

        else:
            # else resize
            size = tuple(map(int, icon_size.split('x')))

            from_image_file = Image.open(original_file_path)
            icon_image_file = from_image_file.resize(size)
            icon_image_file.save(generated_file_path)

    if copy_to_apps and os.path.isfile(generated_file_path) and copy_name:
        (file_path, file_name) = os.path.split(copy_name)

        file_path = os.path.normpath(file_path)
        file_path = os.path.join(project_base, file_path)

        copy_to_path = os.path.join(file_path, file_name)

        if not os.path.exists(file_path):
            print("Path not found, making it:", file_path)
            os.makedirs(file_path)

        shutil.copyfile(generated_file_path, copy_to_path)


def validate_csv(fields, row, originals_path, generated_path, base):
    valid = True

    project_base = os.path.abspath(base)

    if not os.path.exists(project_base):
        valid = False
        print("Project root not found:", project_base)
        return valid

    if fields.get("Icon Size") is None:
        valid = False
        print("Field not found in CSV file:", "Icon Size")

    if fields.get("From Size") is None:
        valid = False
        print("Field not found in CSV file:", "From Size")

    if fields.get("Original") is None:
        # We will treat "Original" as optional and not check it
        pass

    if not row:
        valid = False
        print("CSV file as no data rows")

    # At this point if everything is okay then confirm directories exist
    if valid:
        if not os.path.exists(originals_path):
            valid = False
            print("Path of original icons not found:", originals_path)

    if valid:
        if not os.path.exists(generated_path):
            print("Path of generated icons not found, making it:", generated_path)
            os.makedirs(generated_path)

    return valid


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--base', help='path of the project root', type=str, required=True)
    parser.add_argument(
        '--originals', help='path of source icons', type=str, required=True)
    parser.add_argument(
        '--generated', help='path of generated icons', type=str, required=True)
    parser.add_argument(
        '--csv', help='csv with bounding box data', type=str, required=True)
    parser.add_argument(
        '--copy', help='yes, copy to apps', type=bool, default=True)
    args = parser.parse_args()

    # Begin by reading the CSV
    fields_list, rows = read_csv(args.csv)

    # Convert fields to a dictionary to make things easier
    fields = {k: v for v, k in enumerate(fields_list)}

    if validate_csv(fields, rows, args.originals, args.generated, args.base):
        for row in rows:
            generate_icon(fields, row, args.originals,
                          args.generated, args.copy, args.base)
