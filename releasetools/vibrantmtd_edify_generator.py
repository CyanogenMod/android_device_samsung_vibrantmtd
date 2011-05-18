#
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os, sys

LOCAL_DIR = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
RELEASETOOLS_DIR = os.path.abspath(os.path.join(LOCAL_DIR, '../../../build/tools/releasetools'))

import edify_generator

class EdifyGenerator(edify_generator.EdifyGenerator):
    def UnpackPackageFile(self, src, dst):
      """Unpack a given file from the OTA package into the given
      destination file."""
      self.script.append('package_extract_file("%s", "%s");' % (src, dst))

    def WriteBMLoverMTD(self, partition, partition_start_block, reservoirpartition, reservoir_start_block, image):
      """Write the given package file into the given partition."""

      args = {'partition': partition, 'partition_start_block': partition_start_block, 'reservoirpartition': reservoirpartition, 'reservoir_start_block': reservoir_start_block, 'image': image}

      self.script.append(
            ('package_extract_file("bml_over_mtd", "/tmp/bml_over_mtd");\n'
             'set_perm(0, 0, 0777, "/tmp/bml_over_mtd");'))        
      self.script.append(
            ('package_extract_file("bml_over_mtd.sh", "/tmp/bml_over_mtd.sh");\n'
             'set_perm(0, 0, 0777, "/tmp/bml_over_mtd.sh");'))
      self.script.append(
            ('assert(package_extract_file("%(image)s", "/tmp/%(partition)s.img"),\n'
             '       run_program("/tmp/bml_over_mtd.sh", "%(partition)s", "%(partition_start_block)s", "%(reservoirpartition)s", "%(reservoir_start_block)s", "/tmp/%(partition)s.img"),\n'
             '       delete("/tmp/%(partition)s.img"));') % args)
